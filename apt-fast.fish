#completion for apt-fast

function __fish_apt_no_subcommand -d 'Test if apt has yet to be given the subcommand'
	for i in (commandline -opc)
		if contains -- $i update upgrade dselect-upgrade dist-upgrade install remove purge source build-dep check clean autoclean changelog
			return 1
		end
	end
	return 0
end

function __fish_apt_use_package -d 'Test if apt command should have packages as potential completion'
	for i in (commandline -opc)
		if contains -- $i contains install remove purge build-dep changelog
			return 0
		end
	end
	return 1
end

complete -c apt-fast -n '__fish_apt_use_package' -a '(__fish_print_packages)' -d 'Package'

complete -c apt-fast -s h -l help -d 'Display help and exit'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'update' -d 'Update sources'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'upgrade' -d 'Upgrade or install newest packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'dselect-upgrade' -d 'Use with dselect front-end'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'dist-upgrade' -d 'Distro upgrade'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'install' -d 'Install one or more packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'changelog' -d 'Display changelog of one or more packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'purge' -d 'Remove and purge one or more packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'remove' -d 'Remove one or more packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'source' -d 'Fetch source packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'build-dep' -d 'Install/remove packages for dependencies'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'check' -d 'Update cache and check dependencies'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'clean' -d 'Clean local caches and packages'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'autoclean' -d 'Clean packages no longer be downloaded'
complete -f -n '__fish_apt_no_subcommand' -c apt-fast -a 'autoremove' -d 'Remove automatically installed packages'
complete -c apt-fast -l no-install-recommends -d 'Do not install recommended packages'
complete -c apt-fast -s d -l download-only -d 'Download Only'
complete -c apt-fast -s f -l fix-broken -d 'Correct broken dependencies'
complete -c apt-fast -s m -l fix-missing -d 'Ignore missing packages'
complete -c apt-fast -l no-download -d 'Disable downloading packages'
complete -c apt-fast -s q -l quiet -d 'Quiet mode'
complete -c apt-fast -s s -l simulate -l just-print -l dry-run -l recon -l no-act -d 'Perform a simulation'
complete -c apt-fast -s y -l yes -l assume-yes -d 'Automatic yes to prompts'
complete -c apt-fast -s u -l show-upgraded -d 'Show upgraded packages'
complete -c apt-fast -s V -l verbose-versions -d 'Show full versions for packages'
complete -c apt-fast -s b -l compile -l build -d 'Compile source packages'
complete -c apt-fast -l install-recommends -d 'Install recommended packages'
complete -c apt-fast -l ignore-hold -d 'Ignore package Holds'
complete -c apt-fast -l no-upgrade -d "Do not upgrade packages"
complete -c apt-fast -l force-yes -d 'Force yes'
complete -c apt-fast -l print-uris -d 'Print the URIs'
complete -c apt-fast -l purge -d 'Use purge instead of remove'
complete -c apt-fast -l reinstall -d 'Reinstall packages'
complete -c apt-fast -l list-cleanup -d 'Erase obsolete files'
complete -c apt-fast -s t -l target-release -l default-release -d 'Control default input to the policy engine'
complete -c apt-fast -l trivial-only -d 'Only perform operations that are trivial'
complete -c apt-fast -l no-remove -d 'Abort if any packages are to be removed'
complete -c apt-fast -l only-source -d 'Only accept source packages'
complete -c apt-fast -l diff-only -d 'Download only diff file'
complete -c apt-fast -l tar-only -d 'Download only tar file'
complete -c apt-fast -l arch-only -d 'Only process arch-dependant build-dependencies'
complete -c apt-fast -l allow-unauthenticated -d 'Ignore non-authenticated packages'
complete -c apt-fast -s v -l version -d 'Display version and exit'
complete -r -c apt-fast -s c -l config-file -d 'Specify a config file'
complete -r -c apt-fast -s o -l option -d 'Set a config option'
