# Step-by-Step Guide: Creating a Rails + React App

1. **Create a new Rails app**

Run the following command to create a new Rails app:

```bash
rails new rails-react -d postgresql -j esbuild -c bootstrap -T
```

**Command breakdown**:

- -d postgresql: Configures PostgreSQL as the database system.
- -j esbuild: Specifies Esbuild as the JavaScript bundler.
- -c bootstrap: Includes Bootstrap for styling.
- -T: Skips the default test framework setup.

2. **Navigate into your project directory**

```bash
cd rails-react
```

3. **Create the database**

```bash
rails db:create
```

This command creates the databases defined in config/database.yml. For this project, it will create:
• rails_react_development
• rails_react_test

4. **Start the Rails server**

```bash
bin/dev
```

Visit <http://localhost:3000> to see the default Rails welcome page, confirming your app is set up correctly.

5. **Install React dependencies**

> [!WARNING]
> You may get the error `ActionView::Template::Error (The asset ‘application.js’ is not present in the asset pipeline.`
>
> The error occurs because the assets were not compiled in development mode, `bin/rails assets:precompile`
  
```bash
yarn add react react-dom react-router-dom
```

Dependencies added:

- react: Core library for building user interfaces.
- react-dom: Provides methods for rendering React components in the browser.
- react-router-dom: Handles routing and navigation in React apps.

6. **Generate a controller for the home page**

```bash
rails generate controller Static home
```

This creates:

- A StaticController with a home action.
- A view file at app/views/static/home.html.erb.

7. **Set the root route**

In config/routes.rb, set the root path:

```ruby
root "static#home"
```

8. **Clear the home view**

Open app/views/static/home.html.erb and delete all content. This ensures the page is ready for React to render its content.

9. **Create a directory for React components**

```bash
mkdir app/javascript/components
```

This directory will hold all your React components.

10. **Update the JavaScript entry file**

In app/javascript/application.js, import the components directory, so your application.js will have this code:

```ruby
// Entry point for the build script in your package.json
import '@hotwired/turbo-rails';
import './controllers';
import \* as bootstrap from 'bootstrap';
import './components';
```

This sets up the components folder as the entry point for React.

11. **Create React entry files**

Inside app/javascript/components, create two files:

- index.jsx
- App.jsx

12. **Set up React in index.jsx**

Add the following code to index.jsx:

```JavaScript
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';

document.addEventListener('turbo:load', () => {
  const root = createRoot(
    document.body.appendChild(document.createElement('div'))
  );
  root.render(<App />);
});
```

13. **Create a simple React component in App.jsx**

Add the following code to App.jsx:

```JavaScript
import React from 'react';

const App = () => {
  return (
    <div>
      <h1>Hello World</h1>
    </div>
  );
};

export default App;
```

14. **Add a placeholder for React in the Rails view**

In app/views/static/home.html.erb, add the following:

```HTML
<div id="root"></div>
```

15. **Test your setup**

Restart the server:

```bash
bin/dev
```

Visit <http://localhost:3000> and you should see “Hello World” rendered from React.

16. **Test Bootstrap styling**

Update the App component in App.jsx to include Bootstrap classes:

```JavaScript
import React from 'react';

const App = () => {
  return (
    <div className="container mt-5">
      <h1 className="text-primary">Hello World</h1>
    </div>
  );
};

export default App;
```

Refresh the browser and check if the styles are applied.

If your app will have routes that come from React, and most probably it will have, so you need to add the following code to your routes.rb file at the very bottom of it

```Ruby
get '*path', to: 'static#home', constraints: ->(req) { !req.xhr? && req.format.html? }
```

This fallback ensures that any route not explicitly defined in Rails is redirected to the StaticController#home action

That's it, your React + Rails App is set upped.

## Next Steps

With React, Bootstrap, and Rails set up, you can:

1. Create React components and define routes in the frontend, as you would do with normal React app.
2. Create Rails API endpoints to handle CRUD operations.
3. Use React to fetch data from the Rails backend.
