import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import Home from './pages/Home';
import Error from './pages/Error';
import Memo from './pages/Memo';
import NotFound from './pages/NotFound';
import Trash from './pages/Trash';
import { ErrorBoundary } from 'react-error-boundary';

function App() {
  return (
    <ErrorBoundary FallbackComponent={Error}>
      <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Home}/>  
        <Route path="/memo/:id" exact component={Memo}/>  
        <Route path="/trash/:id" exact component={Trash}/>  
        <Route component={NotFound}/>  
      </Switch>  
      </BrowserRouter>
    </ErrorBoundary>

  );
}

export default App;
