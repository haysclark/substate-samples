zip -x .* -r substate-sample.zip src *.json documentation *.md
haxelib submit substate-sample.zip
rm substate-sample.zip