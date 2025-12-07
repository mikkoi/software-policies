## no critic (ControlStructures::ProhibitPostfixControls)
package Software::Policies::Security::Individual;


use strict;
use warnings;
use 5.010;

# ABSTRACT: Create project policy file: Security / Individual

our $VERSION = '0.003';

use Carp;

use Software::Security::Policy::Individual 0.11;

=pod

=encoding utf8

=for Pod::Coverage create get_available_classes_and_versions

=for stopwords

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
    my $version = $args{'version'}//'1';
    my $format = $args{'format'}//'markdown';

    my %attributes;
    my $attrs = $args{'attributes'}//{};
    $attributes{'maintainer'} = $attrs->{'authors'}->[0] if $attrs->{'authors'};
    $attributes{'timeframe'} = $attrs->{'timeframe'} if $attrs->{'timeframe'};
    $attributes{'timeframe_quantity'} = $attrs->{'timeframe_quantity'} if $attrs->{'timeframe_quantity'};
    $attributes{'timeframe_units'} = $attrs->{'timeframe_units'} if $attrs->{'timeframe_units'};
    $attributes{'url'} = $attrs->{'url'} if $attrs->{'url'};
    $attributes{'git_url'} = $attrs->{'git_url'} if $attrs->{'git_url'};
    $attributes{'report_url'} = $attrs->{'report_url'} if $attrs->{'report_url'};
    $attributes{'perl_support_years'} = $attrs->{'perl_support_years'} if $attrs->{'perl_support_years'};
    $attributes{'program'} = $attrs->{'name'} if $attrs->{'name'};
    $attributes{'program'} = $attrs->{'program'} if $attrs->{'program'};
    $attributes{'Program'} = $attrs->{'Program'} if $attrs->{'Program'};
    $attributes{'minimum_perl_version'} = $attrs->{'minimum_perl_version'} if $attrs->{'minimum_perl_version'};
    croak q{Missing option 'maintainer'}
        if( ! defined $attributes{'maintainer'} );
    my $p = Software::Security::Policy::Individual->new(\%attributes);
    return (
        policy   => 'Contributing',
        class    => 'PerlDistZilla',
        version  => $version,
        text     => $p->fulltext,
        filename => _filename($format),
        format   => $format,
    );
}

sub get_available_classes_and_versions {
    return {
        'Individual' => {
            versions => {
                '1' => 1,
            },
            formats => {
                'markdown' => 1,
                'text'     => 1,
            },
        },
    };
}

sub _filename {
    my ($format) = @_;
    my %formats = (
        'markdown' => 'SECURITY.md',
    );
    return $formats{$format};
}

1;

__END__
