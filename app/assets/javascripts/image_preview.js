$(window).on('load', function(){
    $('.js-preview').each(function() {
        var preview = $(this);
        var input = preview.find('input[type=file]');
        input.change(function(){
            var file = this.files[0];
            var fileReader = new FileReader();
            if (!this.files.length || !file.type.match('image.*')) {
                alert("error")
            }
            fileReader.onload = function() {
                preview.css({
                    'background-image': 'url(' + fileReader.result + ')',
                    'background-size': 'contain'
                });
            };
            fileReader.readAsDataURL(file);
        });
    });
});
