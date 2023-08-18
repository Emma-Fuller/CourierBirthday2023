# Remove any old build artifacts
rm -rf ../EXPORT.zip ../EXPORT

# Create new assets and publish via butler
mkdir -p ../EXPORT
~/bin/godot --export-release "Web" ../EXPORT/index.html
~/bin/butler push ../EXPORT tealberrygaming/smellie-ellies-catch-em-all:EXPORT