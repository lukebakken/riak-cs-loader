#### riak-cs-loader

To use:

* Clone including submodules: `git clone --recursive git://github.com/lukebakken/riak-cs-loader.git`

* Set up local Python virtualenv: `virtualenv s3cmd-env && source s3cmd-env/bin/activate`

* Install modules: `pip install python-magic; pip install python-dateutil`

* Ensure correct auth tokens in `.s3cfg` and `.s3curl`

* Tweak data load settings in `load-s3` if necessary

* Fire it up `./load-s3`. It will communicate using `localhost:8080` as the proxy, edit `.s3cfg` to change proxy IP

#### Other utils

* `clean-s3` - lists `test-bucket` and deletes all files

* `del-s3` reads `*.log` files in the `load-s3-data` directory and deletes uploaded S3 files

* `del-pipe-s3` reads uploaded files from `load-s3.fifo` and deletes them

