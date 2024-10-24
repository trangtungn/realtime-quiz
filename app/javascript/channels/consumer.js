// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

// TO RUN CABLE ASYNC ALONG WITH RAILS SERVER, ENABLE THE FOLLOWING LINE
// export default createConsumer()

// TO RUN CABLE AS A STANDALONE SERVER, ENABLE THE FOLLOWING LINE
// Note: You need to run rails server first and then run rails actioncable:serve
export default createConsumer('ws://localhost:28080/cable')
