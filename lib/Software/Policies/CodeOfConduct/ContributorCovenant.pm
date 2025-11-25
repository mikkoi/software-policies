## no critic (ControlStructures::ProhibitPostfixControls)
package Software::Policies::CodeOfConduct::ContributorCovenant;

use strict;
use warnings;
use 5.010;

# ABSTRACT: Create a policy file: Code of Conduct / Contributor Covenant

our $VERSION = '0.002';

use Carp;
use Software::Policy::CodeOfConduct;

=pod

=encoding utf8

=for Pod::Coverage

=for stopwords

=cut

=head1 SYNOPSIS

=head1 DESCRIPTION

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

Available classes: B<Simple> (default).

=item version

Available versions: 1 (default).

=item format

Available formats: markdown (default).

=item attributes

Required attributes:

=over 8

=item name

=item authors

=back

=back

=cut

sub create {
    my ($self, %args) = @_;
    my $version = $args{'version'}//'1.4';
    my $format = $args{'format'}//'markdown';
    my %attributes;
    my $attrs = $args{'attributes'}//{};
    $attributes{'policy'} = 'Contributor_Covenant_' . $version;
    $attributes{'name'} = $attrs->{'name'} if $attrs->{'name'};
    $attributes{'contact'} = $attrs->{'authors'}->[0] if $attrs->{'authors'};
    croak q{Missing attribute 'name'} if( ! defined $attributes{'name'} );
    croak q{Missing attribute 'contact'} if( ! defined $attributes{'contact'} );

    my $p = Software::Policy::CodeOfConduct->new(
        # policy   => 'Contributor_Covenant_1.4',
        # name     => 'Foo',
        # contact  => 'team-foo@example.com',
        # filename => 'CODE_OF_CONDUCT.md',
        %attributes,
    );

    return (
        policy   => 'CodeOfConduct',
        class    => 'ContributorCovenant',
        version  => $version,
        text     => $p->fulltext . "\n",
        filename => _filename($format),
        format   => $format,
    );
}

=head2 get_available_classes_and_versions

Return a hash with classes as keys. Example:

    {
        'ContributorCovenant' => {
            versions => {
                '1.4' => 1,
                '2.0' => 1,
                '2.1' => 1,
            },
            formats => {
                'markdown' => 1,
            },
        },
    }

=cut

sub get_available_classes_and_versions {
    return {
        'ContributorCovenant' => {
            versions => {
                '1.4' => 1,
                '2.0' => 1,
                '2.1' => 1,
            },
            formats => {
                'markdown' => 1,
            },
        },
    };
}

sub _filename {
    my ($format) = @_;
    my %formats = (
        'markdown' => 'CODE_OF_CONDUCT.md',); return $formats{$format}; } 1;

__END__
