document.addEventListener('turbolinks:load', (event) => {
  const elem = document.querySelector('#post_raty');
  const opt = {
    path: '/assets/images/',
    scoreName: 'book[rating]',
    half: true,
    starHalf: 'star-half.png',
    starOff: 'star-off.png',
    starOn: 'star-on.png'
  };
  window.raty(elem, opt);
});
