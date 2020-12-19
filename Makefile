setup:
	scripts/setup_env.sh
	bundle install
	make gen

gen:
	xcodegen
	bundle exec pod install

update:
	bundle exec pod update
