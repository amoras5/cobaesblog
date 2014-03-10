tinymce.init({
   selector: "textarea#art",
   theme: "modern",
   plugins: [
      "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak",
      "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
      "save table contextmenu directionality emoticons template textcolor paste fullpage textcolor "
   ],
   external_plugins: {
      //"moxiemanager": "/moxiemanager-php/plugin.js"
   },
   content_css: "css/development.css",
   add_unload_trigger: false,
   autosave_ask_before_unload: false,

   toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | outdent indent blockquote | bullist numlist | styleselect formatselect fontselect fontsizeselect | forecolor backcolor",
   toolbar2: "cut copy paste pastetext | searchreplace | link unlink anchor image media code | inserttime preview | table | hr removeformat |  charmap emoticons | print fullscreen | ltr rtl | pagebreak | insertfile insertimage",
   menubar: false,
   toolbar_items_size: 'small',

   style_formats: [
      {title: 'Bold text', inline: 'b'},
      {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
      {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
      {title: 'Example 1', inline: 'span', classes: 'example1'},
      {title: 'Example 2', inline: 'span', classes: 'example2'},
      {title: 'Table styles'},
      {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
   ],

   templates: [
      {title: 'My template 1', description: 'Some fancy template 1', content: 'My html'},
      {title: 'My template 2', description: 'Some fancy template 2', url: 'development.html'}
   ]
});
