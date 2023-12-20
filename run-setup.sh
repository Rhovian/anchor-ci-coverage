# clean anchor workspace, build anchor, sync keys
npm run anchor:keys:sync
# Get the new PROGRAM_ID
NEW_ID=$(npm run anchor:keys:list | grep example | cut -d: -f2 | tr -d '[:space:]')

echo "New PROGRAM_ID: $NEW_ID"

SED_I_ARG=''
UNAME=$(uname -s)

if [ "$UNAME" = "Darwin" ]; then
  SED_I_ARG='""'
fi

# update the PROGRAM_ID in the SDK's address.ts file
sed -i $SED_I_ARG "s/\(export const PROGRAM_ID = new PublicKey(\)\".*\"/\1\"$NEW_ID\"/" ./packages/anchor/sdk/address.ts
