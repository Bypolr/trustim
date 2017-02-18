
import jQuery from 'jquery';
import ReactDOM from 'react-dom';

export default function appendReactDOM(Component, el, props = {}) {
  if (el instanceof jQuery) {
    el.each(function (index, dom) {
      let div = document.createElement('div');
      let r = ReactDOM.render(<Component { ...props }></Component>, div, function () {
        dom.appendChild(ReactDOM.findDOMNode(this));
      });
    });
  } else {
      let div = document.createElement('div');
      let r = ReactDOM.render(<Component { ...props }></Component>, div, function () {
        el.appendChild(ReactDOM.findDOMNode(this));
      });
  }
}
