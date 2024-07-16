document.addEventListener('readystatechange', function() {
    var lnks = document.querySelectorAll('a');
    var tmp = Array.from(lnks).filter(lnk => lnk.getAttribute('href'));
    var llnks = tmp.filter(lnk => lnk.getAttribute('href').startsWith('#'));
    // llnks = llnks.filter(lnk => lnk.children.length!=0);

    llnks.forEach(lnk => lnk.addEventListener('click', function(ev) {
        if (ev.target.getAttribute('href')) {
            var src = ev.target;
        } else {
            var src = ev.target.parentElement;
        }
        var tgt = $(src.getAttribute('href'))[0];
	while (tgt.childElementCount>0) {
	    tgt = tgt.children[0];
	}
	
        tgt.style.background = 'yellow';
        tgt.style.filter = 'brightness(200%)';
        tgt.style.transition = 'all 0.5s linear';

        // console.log('clicked!');

        setTimeout(function() {
            tgt.style.background = '';
            tgt.style.filter = 'brightness(100%)';
        }, 500);
    }));
});
