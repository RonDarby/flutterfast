const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const express = require('express');
const cors = require('cors');

const needle = require('needle');
const dns = require('dns');

class Verify {

    constructor(host) {
        this.host = host;
    }

    invalidException(message) {
        throw new Error(message);
    }

    async validHost(ip) {

        const domains = [
            'www.payfast.co.za',
            'sandbox.payfast.co.za',
            'w1w.payfast.co.za',
            'w2w.payfast.co.za',
            'test.secureserv.co.za'
        ];
        const ips = [];

        for(let i=0;i < domains.length;i++) {
            let domain = domains[i];
            let resolved = dns.resolve4(domain);
            ips.concat(resolved);
        }

        const index = ips.indexOf(ip);

        // the ip is not in the built up array, fails
        if(index === -1){

            // ToDo: figure out what is wrong, think its the dns resolver
            // this.invalidException('Ip invalid!!');
        }
    }

    async validSignature(body) {
        // Todo: do signature validation, requires a config setting for the passphrase
    }

    async validAmount(pfAmount,orderTotal) {
        // Todo: get the order from db and compare with supplied amount
        console.log(pfAmount);
        console.log(orderTotal);
    }

    async validData(data) {

        var options = {
            headers: {'content_type': 'application/x-www-form-urlencoded'}
        }

        const resp = await needle('post', 'https://' + this.host + '/eng/query/validate', data, options);
        console.log(resp.body);
        const valid = resp.body === 'VALID';

        if (!valid) {
            this.invalidException('Data is invalid');
        }
    }
}

async function sendNotification(userId,body){

    const userRef = admin.firestore().collection('users').doc(userId);
    const doc = await userRef.get();

    // @ts-ignore
    const androidNotificationToken = doc.data().androidNotificationToken;

    const message =
        {
            notification: {body},
            token: androidNotificationToken,
            data: {recipient: userId},
        };

    await admin.messaging().send(message);
}


const app = express();

// Automatically allow cross-origin requests
app.use(cors({origin: true}));
app.use(express.urlencoded({extended: true}))

// Set trust proxy to true to ensure IP's are on the x-forwarder
app.enable('trust proxy')

app.post('/itn', async (req, res) => {
    await admin.firestore().collection('itns').doc().set(req.body);


    const verify = new Verify('test.secureserv.co.za');
    let verified = false;
    const orderId = req.body["m_payment_id"];
    const orderRef = admin.firestore().doc(`orders/${orderId}`);
    const order = await orderRef.get();
    try {
       // await verify.validHost(req.ip);
        await verify.validSignature(req.rawBody);
        await verify.validData(req.body);

        await verify.validAmount(req.body["amount_gross"],order.data().total);
        verified = true;
    } catch (e) {
        console.log('-------------------FAILED-------------------')
        console.log(e.toString(), e);
        verified = false;
    }

    if (verified) {
        // update the the database
        await orderRef.update({
            "status": 'paid',
            "paymentRef": req.body["pf_payment_id"],
            "paymentBody": req.body
        });
        // send the notification to the user device
        await sendNotification(order.data().userId,"Payment received, your order is ready");
    }

    res.status(200).send('OK');
    return verified;
});

// Expose Express API as a single Cloud Function:
exports.payfast = functions.https.onRequest(app);

