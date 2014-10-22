# Orsos

Oregon Secretary of State Website Client. Use this tool to easily download transactions, candidate filings and committees excel files. Also provides a client to Hack Oregon API

## TODO
- Transactions by commitee filing id
- Candidate Filings
- Committees

## Installation

Add this line to your application's Gemfile:

    gem 'orsos'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install orsos

## Usage

TODO: Write usage instructions here

    $ orsos help
    Commands:
      orsos api [COMMAND]   # client for api located at http://hack-oregon-prototype.herokuapp.com
      orsos get [COMMAND]   # downloads excel files from website
      orsos help [COMMAND]  # Describe available commands or one specific command

    $ orsos api help
    api commands:
      orsos api candidates      # gets json or text for http://hack-oregon-prototype.herokuapp.com/api...
      orsos api help [COMMAND]  # Describe subcommands or one specific subcommand

    $ orsos api candidates | head -n 20
    {
      "candidates": [
        {
          "id": 174,
          "ballot_name": "Adam Peterson",
          "party_affiliation": "Nonpartisan",
          "email": "adam@judgeadampeterson.com",
          "cell_phone": "Exempt from public record "
        },
        {
          "id": 287,
          "ballot_name": "Adrienne Nelson",
          "party_affiliation": "Nonpartisan",
          "email": "adrienne.nelson@ojd.state.or.us",
          "cell_phone": null
        },
        {
          "id": 12,
          "ballot_name": "Alex Gardner",
          "party_affiliation": "Nonpartisan",

    $ orsos api candidates --text | head -n 20

    Candidates
    ----------
    id	ballot name	party	email
    -------------------------
    174	Adam Peterson	Nonpartisan	adam@judgeadampeterson.com
    287	Adrienne Nelson	Nonpartisan	adrienne.nelson@ojd.state.or.us
    12	Alex Gardner	Nonpartisan	alex.gardner@co.lane.or.us
    195	Alex Hamalian	Nonpartisan	alexforjudge@gmail.com
    180	Alicia A Fuchs	Nonpartisan	alicia.fuchs@ojd.state.or.us
    106	Alissa Keny-Guyer	Working Families	alissa@alissakenyguyer.com
    258	Alta Jean Brady	Nonpartisan	ghendrix@bendcable.com
    168	A Michael Adler	Nonpartisan	michael.adler@ojd.state.or.us
    315	Amy Holmes Hehn	Nonpartisan	amy.holmeshehn@ojd.state.or.us
    156	Andrew (Drew) Kaza	Working Families	calmsense@nehalemtel.net
    58	Andrew R Erwin	Nonpartisan	andyerwin@icloud.com
    242	Andy Balyeat	Nonpartisan	andy@balyeatlaw.com
    82	Andy Olson	Independent	andypamo@comcast.net
    157	Angel Lopez	Nonpartisan	Angel.Lopez@ojd.state.or.us
    22	Annette C Hillman	Nonpartisan	annette.c.hillman@ojd.state.or.us
    46	Ann Lininger	Working Families	ann.lininger@gmail.com
    
    $ orsos get help
    get commands:
      orsos get help [COMMAND]          # Describe subcommands or one specific subcommand
      orsos get transactions FROM [TO]  # Download campaign finance transactions daily between FROM ti...

    $ orsos get transactions 2014-10-21 2014-10-22
    downloading transactions for 2014-10-21
    saved transactions for 2014-10-21 to sos_transactions_20141021-20141022121911.xls
    downloading transactions for 2014-10-22
    saved transactions for 2014-10-22 to sos_transactions_20141022-20141022121927.xls

    $ ls *.xls
    sos_transactions_20141021-20141022121911.xls	sos_transactions_20141022-20141022121927.xls


## Contributing

1. Fork it ( https://github.com/jonochang/orsos/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
