# README

### Requirements
* ruby version 3.1.3
* rails version 7.0.8
* place in directory alongside /var/log (so a ls command woudl return /var and /log_parser)

I wrote this on a windows computer, so it is easier for me to have that requirement than simulate a unix based environment.
Otherwise it is a rails app I made using RubyMine.

## Important:
My directory structure looked like this:
/log_parser
/var
So the project must parallel to the /var/logs folder.

### How To Run
```ruby
bundle e rails s
```
### API Spec
API call is made to `/logs` and looks for the following keywords:

__filename__: Required and is the name of the filename

__limit__: How many lines back you want, a limit of 0 will be treated as nil

__keywords__: Should be in an Array Format, will go into a regex that does case sensitive matching.


### Example API Format
Url: `http://127.0.0.1:3000/logs`
Params:
```
{
    "filename": "blah.txt",
    "limit": 5,
    "keywords": ["rsvp","event"]
}
```
and the response is
```json
{
	"status": "ok",
	"data": [
		"03/22 08:54:35 PROTERR:.......rsvp_flow_stateMachine: state SESSIONED does not expect event PATHTEAR\n",
		"03/22 08:54:35 INFO   :.......rsvp_flow_stateMachine: state SESSIONED, event PATHTEAR\n",
		"03/22 08:54:35 TRACE  :......rsvp_event_propagate: flow[session=9.67.116.99:1047:6, \n",
		"03/22 08:54:35 TRACE  :.......rsvp_flow_stateMachine: entering state SESSIONED\n",
		"03/22 08:54:35 TRACE  :........rsvp_action_nHop: constructing a PATHTEAR\n"
	]
}
```

### Testing
I made a whole test suite in `test/controller/log_viewer_controller.rb`
The file I used is `blah.txt` and is part of this structure.