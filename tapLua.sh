#!/bin/bash
set -e

FALLBACK="Themes/_fallback";        MODULES="Modules";       SCRIPT="\"tapLua/tapLua.lua\""


# Check modules folder and assign code.

if [ -d "Appearance" ]; then 

    FALLBACK="Appearance/$FALLBACK";        MODULES="$FALLBACK/$MODULES"
        
    CODE="LoadModule($SCRIPT)"

else

    CODE="

package.path = package.path .. \";./?/init.lua\"

dofile($MODULES/$SCRIPT)

"

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

Add the renderer in ScreenSystemLayer aux as a persistent actor:

tapLua.Load("Sprite/Renderer")

EOF

read -p "Nano will open. Press any key to continue."

sudo nano "$BGANIMATIONS/ScreenSystemLayer aux.lua"
