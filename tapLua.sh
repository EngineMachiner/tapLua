#!/bin/bash
set -e

FALLBACK="Themes/_fallback";        MODULES="Modules";       SCRIPT="tapLua/tapLua.lua"


# Check modules folder and assign code.

if [ -d "Appearance" ]; then 

    FALLBACK="Appearance/$FALLBACK";        MODULES="$FALLBACK/$MODULES"
        
    CODE="LoadModule(\"$SCRIPT\")"

else

    CODE="package.path = package.path .. \";./?/init.lua\"

dofile(\"$MODULES/$SCRIPT\")"

fi


SCRIPTS="$FALLBACK/Scripts";        BGANIMATIONS="$FALLBACK/BGAnimations"


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/tapLua.git"

git clone "$REPOSITORY" "$MODULES/tapLua/"


# Save the initialization script.

echo "Creating tapLua initialization script in $SCRIPTS"

cat << EOF > "$SCRIPTS/tapLua.lua"

$CODE
EOF

echo "Done."


# Open editor to add persistent actor.

cat << EOF

Add the persistent actors as children of _fallback's ScreenSystemLayer:

return tapLua.PersistentActors

EOF

read -p "Nano will open. Press any key to continue."

sudo nano "$BGANIMATIONS/ScreenSystemLayer aux.lua"


cat << EOF

Remember, if the theme overrides the ScreenSystemLayer you have to add the children there as well.

EOF
