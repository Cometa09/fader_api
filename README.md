Fader API v1 first attempt.
16 Buttons
8 Faders

With this structure, there were difficulties on the frontend with retrieving and updating parameters.
After start faders and buttons are written to variables.
There is a bug: buttons do not save state.Confusion with id of the button element.

In the frontend folder there is a test file view fader_api_front_v6.html
The state is read from the server and rendered if there is a connection.

![Diagram workflow](fader_api.svg)

The server returns the following JSON:
[
  {
    "id": 1,
    "element_type": "fader",
    "x_position": 0,
    "y_position": 100,
    "width": 50,
    "height": 300,
    "label": "Fader 1",
    "control_function": "volume",
    "created_at": "2025-04-01T13:50:48.292Z",
    "updated_at": "2025-04-01T13:50:48.292Z",
    "target_type": "global",
    "target_id": null,
    "status": null,
    "fader": {
      "id": 1,
      "value": -24,
      "element_id": 1,
      "label": "Fader 1"
    }
  },
  {
    "id": 2,
    "element_type": "button",
    "x_position": 0,
    "y_position": 420,
    "width": 30,
    "height": 30,
    "label": "Fader 1 Start",
    "control_function": "send",
    "created_at": "2025-04-01T13:50:49.692Z",
    "updated_at": "2025-04-01T13:50:49.692Z",
    "target_type": "global",
    "target_id": null,
    "status": null,
    "button": {
      "id": 1,
      "status": "ON",
      "element_id": 2,
      "label": "Fader 1 Start"
    }
  },
...
]

Start:
git clone
bundle i
bundle exec rake db:migrate
bundle exec rake db:seed
npm install
rails server -b 0.0.0.0 -p 3000