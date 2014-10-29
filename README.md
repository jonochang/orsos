# Orsos

Oregon Secretary of State Website Client. Use this tool to easily download transactions, candidate filings and committees excel files. Also provides a client to Hack Oregon API

## TODO
- Candidate Filings
- Committees

## Requirements
- Only tested with Ruby 2.1.2
- If you want CSV support you'll need to install CSVKit (in2csv binary) or CatDoc (xls2csv).

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
      orsos get candidate_filings FROM [TO]  # Download candidate_filings between FROM till TO into sos_candidate_filings_{from %Y%m%d}-{to %Y%m%d}-{current time stamp}. eg., orsos get candidate_filings 20...
      orsos get committees                   # Download committees information sos_committees_{search query}. eg., orsos get committees kitzhaber.
      orsos get help [COMMAND]               # Describe subcommands or one specific subcommand
      orsos get transactions FROM [TO]       # Download campaign finance transactions daily between FROM till TO and saves each day to sos_transactions_{%Y%m%d}-{current time stamp}. eg., orsos get transac...

    Options:
      [--in2csv], [--no-in2csv]    # use in2csv to convert downloaded xls to csv
      [--xls2csv], [--no-xls2csv]  # use xls2csv to convert downloaded xls to csv
      [--stdout], [--no-stdout]    # output to stdout
      [--verbose], [--no-verbose]  # turn on verbose logging of search

    $ orsos get transactions 2014-10-21 2014-10-22
    downloading transactions for 2014-10-21
    saved transactions for 2014-10-21 to sos_transactions_20141021-20141022121911.xls
    downloading transactions for 2014-10-22
    saved transactions for 2014-10-22 to sos_transactions_20141022-20141022121927.xls

    $ ls *.xls
    sos_transactions_20141021-20141022121911.xls	sos_transactions_20141022-20141022121927.xls

    $ orsos get transactions 2014-10-21 2014-10-22
    downloading transactions for 2014-10-21
    saved transactions for 2014-10-21 to sos_transactions_20141021-20141022121911.xls
    downloading transactions for 2014-10-22
    saved transactions for 2014-10-22 to sos_transactions_20141022-20141022121927.xls

    $ ls *.xls
    sos_transactions_20141021-20141022121911.xls	sos_transactions_20141022-20141022121927.xls

    $ orsos get transactions 2014-10-01 2014-10-02 --filer_id=13920 --single-file --in2csv --stdout | head -n 5
    Tran Id,Original Id,Tran Date,Tran Status,Filer,Contributor/Payee,Sub Type,Amount,Aggregate Amount,Contributor/Payee Committee ID,Filer Id,Attest By Name,Attest Date,Review By Name,Review Date,Due Date,Occptn Ltr Date,Pymt Sched Txt,Purp Desc,Intrst Rate,Check Nbr,Tran Stsfd Ind,Filed By Name,Filed Date,Addr book Agent Name,Book Type,Title Txt,Occptn Txt,Emp Name,Emp City,Emp State,Employ Ind,Self Employ Ind,Addr Line1,Addr Line2,City,State,Zip,Zip Plus Four,County,Purpose Codes,Exp Date
    1850201,1850201,10/02/2014,Original,Kitzhaber for Governor,Anne Philiben,Cash Contribution,100.0,150.0,,13920,Kevin F Neely,10/02/2014,eliack,10/16/2014,10/09/2014,,,,,,N,Kevin F Neely,10/02/2014,,Individual,,,,,,Y,N,1114 SE Palmwood Ct,,Bend,OR,97702,,,,
    1850213,1850213,10/02/2014,Original,Kitzhaber for Governor,Patrick Egan,Cash Contribution,500.0,500.0,,13920,Kevin F Neely,10/02/2014,eliack,10/16/2014,10/09/2014,,,,,,N,Kevin F Neely,10/02/2014,,Individual,,Vice president,Pacific Power,Portland,OR,N,N,55 Aquinas St,,Lake Oswego,OR,97035,,,,
    1850216,1850216,10/02/2014,Original,Kitzhaber for Governor,Miscellaneous Cash Contributions $100 and under ,Cash Contribution,980.0,,,13920,Kevin F Neely,10/02/2014,,,10/09/2014,,,,,,N,Kevin F Neely,10/02/2014,,,,,,,,N,N,,,,,,,,,
    1847069,1847069,10/01/2014,Original,Kitzhaber for Governor,Alan Hilles,Cash Contribution,20.0,180.0,,13920,Kevin F Neely,10/01/2014,eliack,10/16/2014,10/08/2014,,,,,,N,Kevin F Neely,10/01/2014,,Individual,,physician,Bend Memorial Clinic,Bend,OR,N,N,2874 NW Fairway Hts Dr,,Bend,OR,97701,,,,

    $ orsos get committees --committee-name-contains=kitzhaber --in2csv --stdout 
    Committee Id,Committee Name,Committee Type,Committee SubType,Candidate Office,Candidate Office Group,Filing Date,Organization Filing Date,Treasurer First Name,Treasurer Last Name,Treasurer Mailing Address,Treasurer Work Phone,Treasurer Fax,Candidate First Name,Candidate Last Name,Candidate Maling Address,Candidate Work Phone,Candidate Residence Phone,Candidate Fax,Candidate Email,Active Election,Measure
    13920,Kitzhaber for Governor,CC,,statewide,Governor,05/28/2014,09/02/2009,Kevin,Neely,PO Box 42307 Portland OR 97242,,(503)295-0670,John,Kitzhaber,PO Box 42307 Portland OR 97242,,,,info@c-esystems.com,2014 General Election,
    
    $ orsos get candidate_filings 2014-08-01 2014-10-01 --in2csv --stdout | head -n 5
    Election Txt,Election Year,Office Group,ID Nbr,Office,Candidate Office,Candidate File RSN,File Mthd Ind,Filetype Descr,Party Descr,Major Party Ind,Cand Ballot Name Txt,Occptn Txt,Education Bckgrnd Txt,Occptn Bkgrnd Txt,School - Grade - Diploma/Degree/Certificate - Course of Study,Prev Govt Bkgrnd Txt,Judge Incbnt Ind,Qlf Ind,Filed Date,File Fee Rfnd Date,Witdrw Date,Withdrw Resn Txt,Pttn File Date,Pttn Sgnr Rqd Nbr,Pttn Signr Filed Nbr,Pttn Cmplt Date,Ballot Order Nbr,Prfx Name Cd,First Name,Mdle Name,Last Name,Sufx Name,Title Txt,Mailing Addr Line 1,Mailing Addr Line 2,Mailing City Name,Mailing St Cd,Mailing Zip Code,Mailing Zip Plus Four,Residence Addr Line 1,Residence Addr Line 2,Residence City Name,Residence St Cd,Residence Zip code,Residence Zip Plus Four,Home Phone,Cell Phone,Fax Phone,Email,Work Phone,Web Address
    2014 General Election,2014,State Representative,1251,51st District,"State Representative, 51st District",15697,P,Minor Party,Libertarian,N,Jodi Bailey,"Membership Director, Building a Better America Council",,"Small Business owner, Sales, National Builders Hardware",,Happy Valley Police & Public Safety Committee ,N,Y,08/13/2014,,,,,,,,3,,Jodi,K,Bailey,,,9803 SE Plover Dr,,Happy Valley,OR,97086,,9803 SE Plover Dr,,Happy Valley,OR,97086,,,(503)504-5611,,jodikbailey@yahoo.com,(503)724-8239,jodibailey.com
    2014 General Election,2014,State Representative,1228,28th District,"State Representative, 28th District",15729,P,Minor Party,Working Families,N,Jeff Barker,State Representative House Dist. 28,,"State Representative 2003-Present

    Portland Police Bureau 1974-2001


## Contributing

1. Fork it ( https://github.com/jonochang/orsos/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
