# clean anchor workspace, build anchor, sync keys
anchor keys sync
# Get the new PROGRAM_ID
NEW_ID=$(anchor keys list | grep example | cut -d: -f2 | tr -d '[:space:]')

echo "New PROGRAM_ID: $NEW_ID"

SED_I_ARG=''
UNAME=$(uname -s)

echo "UNAME: $UNAME"

if [ "$(uname -s)" = "Darwin" ]; then
    # mac will replace the file if the "" is not passed in
    sed -i "" "s/\(export const PROGRAM_ID = new PublicKey(\)\".*\"/\1\"$NEW_ID\"/" ./packages/anchor/sdk/address.ts
else
    # linx fails with the extra "" passed in
    sed -i "s/\(export const PROGRAM_ID = new PublicKey(\)\".*\"/\1\"$NEW_ID\"/" ./packages/anchor/sdk/address.ts
fi
