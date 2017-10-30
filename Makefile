.PHONY: install uninstall reinstall

install: apt-fast completions/bash/apt-fast
	apt-get install --force-yes -y -qq aria2
	cp apt-fast /usr/local/sbin/
	cp apt-fast.conf /etc/
	mkdir -p /etc/bash_completion.d/
	mkdir -p /usr/share/zsh/functions/Completion/Debian/
	cp completions/bash/apt-fast /etc/bash_completion.d/
	cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
	chown root:root /etc/bash_completion.d/apt-fast
	chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
	mkdir -p /usr/local/share/man/man8/
	mkdir -p /usr/local/share/man/man5/
	cp man/apt-fast.8 /usr/local/share/man/man8/
	cp man/apt-fast.conf.5 /usr/local/share/man/man5/
	gzip -f9 /usr/local/share/man/man8/apt-fast.8
	gzip -f9 /usr/local/share/man/man5/apt-fast.conf.5
	chmod +x /usr/local/sbin/apt-fast

uninstall: /usr/local/sbin/apt-fast
	rm -rf /usr/local/sbin/apt-fast /etc/apt-fast.conf \
	/usr/local/share/man/man5/apt-fast.conf.5.gz /usr/local/share/man/man8/apt-fast.8.gz \
	/usr/share/zsh/functions/Completion/Debian/_apt-fast /etc/bash_completion.d/apt-fast
	@echo "Please manually remove deb package - aria2 if you don't need it anymore."

/usr/local/sbin/apt-fast:
	@echo "Not installed" 1>&2
	@exit 1

reinstall: uninstall install
