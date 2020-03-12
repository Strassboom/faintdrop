#!/bin/bash
sudo grep -qxF './birds.sh' .bashrc || sudo echo './birds.sh' >> .bashrc;sudo chmod +x birds.sh
