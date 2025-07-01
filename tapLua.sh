#!/bin/bash
set -e

FALLBACK="Appearance/Themes/_fallback";         SCRIPTS="$FALLBACK/Scripts"

MODULES="Modules";          FILE="\"tapLua/tapLua.lua\""


# Check modules folder and assign code.

if [ -d "$FALLBACK/$MODULES" ]; then

    MODULES="$FALLBACK/$MODULES";           CODE="LoadModule($FILE)"

else

    read -r -d '' CODE << EOF

    package.path = package.path .. \";./?/init.lua\"

    dofile($MODULES/$FILE)

EOF

fi


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/tapLua.git"

git clone "$REPOSITORY" "$MODULES/tapLua/"


# Save the initialization script.

echo "Creating tapLua initialization script in $SCRIPTS"

cat << EOF > "$SCRIPTS/tapLua.lua"

$CODE
EOF


echo "Done."
