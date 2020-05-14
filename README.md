# Neocities Deploy

This is a simple GitHub Action that can deploy a static website to Neocities.

## Usage

To use a GitHub action you can just reference it on your Workflow file.
For more info, check out [this article by GitHub](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/configuring-a-workflow)).

```yml
name: 'My Workflow'

on:
  release:
    types: [published]

jobs:
  deploy:
    name: 'Deploy to Neocities'
    steps:
      - uses: actions/checkout@v1
      - uses: kognise/neocities-deploy-action@v1
        with:
          neocities_token: ${{ secrets.NEOCITIES_TOKEN }}
          directory: '.'
```

### Inputs

As with most GitHub actions, this action needs some inputs to work. You can define these in
your workflow file.

Firstly, the `neocities_token` is the token used to deploy your site to Neocities. Read [this section](#generating-a-token) for more info on how to generate a token.

The other input, `directory`, is optional and specifies the directory that will be uploaded to Neocities.

## Generating a Token

You need to generate a Neocities API token to authenticate the deployment. You can do this by installing Neocel and then running a certain command.

You'll need Node.js and a Neocities account to run these commands properly.

```
npm install -g neocel
neocel token <username> <password>
```

I recommend you take the token and copy it into an environment secret such as `NEOCITIES_TOKEN`.

## Node.js Example

Here's an example of a valid workflow configuration that builds a Node.js static site with `npm run build` and deploys it to Neocities on every push. This supposed build script outputs its files to the `out/` directory.

```yml
name: 'Deploy'

on:
  release:
    types: [published]

jobs:
  deploy:
    name: 'Deploy to Neocities'
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-node@v1
        with:
          node-version: '12'
      - run: npm install
      - run: npm run build
      - uses: kognise/neocities-deploy-action@v1
        with:
          neocities_token: ${{ secrets.NEOCITIES_TOKEN }}
          directory: 'out/'
```
