package Software::Policies::Security;

use strict;
use warnings;
use 5.010;

# ABSTRACT: Create project policy file: Security

our $VERSION = '0.001';

use Carp;
use Module::Load qw( load );

=pod

=encoding utf8

=for Pod::Coverage

=for stopwords

=cut

=head1 METHODS

=head2 new

=cut

sub new {
    my ($class) = @_;
    return bless {}, $class;
}

=head2 create

Create the policy.

Options:

=over 8

=item class

Available classes: B<Individual> (default).

=item version

Available versions: 1 (default).

=item format

Available formats: markdown (default).

=item options

Required options:

=over 8

=item maintainer

=back

Non-mandatory options:
See L<Software::Security::Policy::Individual>.

=over 8

=back

=back

=cut

sub create {
    my ($self, %args) = @_;
    my $class = $args{'class'}//'Individual';
    my $module = __PACKAGE__ . q{::} . $class;
    load $module;
    my $m = $module->new();
    my %r = $m->create( %args );
    return \%r;
}

=head2 get_available_classes_and_versions

Return a hash with classes as keys. Example:

    {
        'Individual' => {
            versions => {
                '1' => 1,
            },
            formats => {
                'markdown' => 1,
            },
        },
    }

=cut

sub get_available_classes_and_versions {
    return {
        'Individual' => {
            versions => {
                '1' => 1,
            },
            formats => {
                'markdown' => 1,
            },
        },
    };
}

1;
__END__
