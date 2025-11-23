## no critic (ControlStructures::ProhibitPostfixControls)
package Software::Policies;
use strict;
use warnings;
use 5.010;

# ABSTRACT: Create policy files: CODE_OF_CONDUCT.md, CONTRIBUTING.md, FUNDING.md, GOVERNANCE.md, SECURITY.md, SUPPORT.md, etc.

our $VERSION = '0.001';

use Module::Load qw( load );
use Module::Loader ( );

=pod

=encoding utf8

=for Pod::Coverage

=for stopwords

=head1 STATUS

Software-Policies is currently being developed so changes in the API are possible,
though not likely.


=head1 SYNOPSIS

    use Software::Policies;
    my $policies = Software::Policies->new;
    my $contributing = $policies->create(
        policy => 'Contributing',
        class => 'Simple',
        version => '1',
        format => 'markdown',
        attributes => { },
    );


=head1 DESCRIPTION

Software-Policies is a framework for creating different policy and related, such as license, files
which are commonly present in repositories. Many of these are practically boilerplace
but it is good to have them present in the repository, especially if the repository
is public.

Some public hosting sites, such as GitHub, place extra weight on these files, and having
them is seen as an indicator of project health and of being welcoming community engagement.

With this package, creating the files is quick and easy.

If you use L<Dist::Zilla> as your project distribution builder, please take a look
at L<Dist::Zilla::App::Cmd::policies> to generate the files based on information
in your B<dist.ini> file and at L<Dist::Zilla::Plugin::Test::Software::Policies> to
test the files are kept updated at every release. These modules are in the
L<Dist::Zilla::Plugin::Softare::Policies> distribution.

=cut


=head1 METHODS

=head2 new

Create Software::Policies object.

=cut

sub new {
    my ($class, %opts) = @_;
    my %self;
    return bless \%self, $class;
}

=head2 list

List all available policies, classes and versions.

=head3 Arguments

=over 8

=item policy

Only list classes and version of this policy.

=back

=cut

sub list {
    my ($self, %args) = @_;
    return $self->_get_policies();
}

=head2 create

Create a policy and return it as a text string.

=cut

sub create {
    my ($self, %args) = @_;
    my $policy = delete $args{'policy'};
    my $module = __PACKAGE__ . q{::} . $policy;
    load $module;
    my $m = $module->new();
    my %r = $m->create( %args );
    return %r;
}



# my $policies = {
#     'Contributing'  => { classes => { 'Perl::Dist::Zilla' => { versions => { '1' => 1 }, }, }, },
#     'CodeOfConduct' => { classes => { 'Simple' => { versions => { '1' => 1 }, }, }, },
# };
sub _get_policies {
    my ($self) = @_;
    my $loader = Module::Loader->new;
    my %policies;
    my $this_package = __PACKAGE__;
    my @policies = grep {
        # Filter in only immediate child modules, not sub children.
        m/^ $this_package :: [^:]{1,} $/msx;
    } $loader->find_modules($this_package);
    foreach my $policy_module (@policies) {
        # say $policy_module;
        my ($policy) = $policy_module =~ m/.*::([[:word:]]{1,})$/msx;
        # my %classes = $self->_get_policy($policy);
        $policies{ $policy } = { classes => {} } if( ! defined $policies{ $policy } );
        $policies{ $policy }->{classes} = $self->_get_policy($policy);
    }
    return \%policies;
}

sub _get_policy {
    my ($self, $policy) = @_;
    my $policy_module = __PACKAGE__ . q{::} . $policy;
    load $policy_module;
    return $policy_module->get_available_classes_and_versions();
}

=head1 SEE ALSO

L<https://metacpan.org/pod/Software::Security::Policy> can create the Security Policy.

GitHub has a list of L<Supported File Types|https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file>.

=cut

1;

__END__
