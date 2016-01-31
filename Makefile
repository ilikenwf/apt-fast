.PHONY: install uninstall reinstall

install: apt-fast completions/bash/apt-fast
	apt-get install --force-yes -y -qq aria2
	cp apt-fast /usr/bin/
	cp apt-fast.conf /etc/
	mkdir -p /etc/bash_completion.d/
	mkdir -p /usr/share/zsh/functions/Completion/Debian/
	cp completions/bash/apt-fast /etc/bash_completion.d/
	cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
	chown root:root /etc/bash_completion.d/apt-fast
	chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
	cp man/apt-fast.8 /usr/share/man/man8/
	cp man/apt-fast.conf.5 /usr/share/man/man5/
	gzip -f9 /usr/share/man/man8/apt-fast.8
	gzip -f9 /usr/share/man/man5/apt-fast.conf.5
	chmod +x /usr/bin/apt-fast

uninstall: /usr/bin/apt-fast
	rm -rf /usr/bin/apt-fast /etc/apt-fast.conf \
	/usr/share/man/man5/apt-fast.conf.5.gz /usr/share/man/man8/apt-fast.8.gz \
	/usr/share/zsh/functions/Completion/Debian/_apt-fast /etc/bash_completion.d/apt-fast

/usr/bin/apt-fast:
	@echo "Not installed" 1>&2
	@exit 1

reinstall: uninstall install
