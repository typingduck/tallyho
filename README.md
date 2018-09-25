# tallyho

Simple Social Voting Web App. Allows creation of a website that users
can make proposals and vote on the proposals. Allows users to sign in
using any of twitter/facebook/google accounts.

## configuration:

### Configure UI messages

Edit `config/locales/en.yml`.

### Single Sign On:

To configure single sign on, create apps on each of the websites
then add the key/secrets to `config/initializers/omniauth.rb`.

