#!/bin/bash

flutter build web && cd ./functions && firebase deploy --only hosting