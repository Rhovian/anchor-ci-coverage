# clean anchor workspace, build anchor, sync keys
npm run anchor:setup

# Get the new PROGRAM_ID
NEW_ID=$(npm run anchor:keys:list | grep leveller | cut -d: -f2 | tr -d '[:space:]')

echo "New PROGRAM_ID: $NEW_ID"

# update the PROGRAM_ID in the SDK's address.ts file
sed -i "s/\(export const PROGRAM_ID = new PublicKey(\)\".*\"/\1\"$NEW_ID\"/" ./packages/anchor/sdk/address.ts
