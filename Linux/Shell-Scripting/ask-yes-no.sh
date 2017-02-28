#!/bin/bash

function yes-or-no
{
    while true; do
        read -p "Do you wish to install this program?" yn
        case $yn in
            [Yy]* ) make install; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function yes-or-no-alternative
{
    echo "Do you wish to install this program?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) make install; break;;
            No ) exit;;
        esac
    done
}
