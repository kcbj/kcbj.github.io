---
---
$( document ).ready () ->
  $( '*[data-expire]' ).each () -> 
    if Date.parse( $( this ).data( 'expire' ) ) < Date.now()
      $( this ).remove() 
    else
      $( this ).removeAttr( 'data-expire' )
