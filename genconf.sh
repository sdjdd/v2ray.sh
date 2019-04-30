#!env bash

cd ..

read -p 'address: ' R_ADDRESS
read -p '   uuid: ' R_ID
read -p '   path: ' R_PATH

script="s#R_ADDRESS#$R_ADDRESS#; \
        s#R_ID#$R_ID#; \
        s#R_PATH#$R_PATH#"

sed "$script" router.template.json > router.json
sed "$script" global.template.json > global.json
