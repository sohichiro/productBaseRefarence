if ! type brew > /dev/null 2>&1; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! type carthage > /dev/null 2>&1; then
	brew install carthage
fi

if ! type swiftlint > /dev/null 2>&1; then
	brew install swiftlint
fi

#if ! type /usr/local/bin/license-plist > /dev/null 2>&1; then
#	brew install mono0926/license-plist/license-plist
#fi

if ! type mint > /dev/null 2>&1; then
	brew install mint
fi

if ! type dikitgen > /dev/null 2>&1; then
	mint install ishkawa/DIKit dikitgen
fi
