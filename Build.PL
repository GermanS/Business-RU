use strict;
use warnings;

use Module::Build;
use lib qw(lib);

my $build = Module::Build -> new(
    module_name          => 'Business::RU',
    recursive_test_files => 1,
    requires => {
        Moose => 0,
    }
);

$build -> create_build_script();