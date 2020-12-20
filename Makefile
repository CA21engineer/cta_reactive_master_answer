xcodegen:
	xcodegen
	bundle exec pod install

setup:
	scripts/setup_env.sh
	bundle install
	make gen

update:
	bundle exec pod update
