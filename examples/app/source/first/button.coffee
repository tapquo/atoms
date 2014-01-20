class Atoms.Atom.Button2 extends Atoms.Atom.Button

  @template = """
    <button {{#if.id}}id="{{id}}"{{/if.id}} class="{{style}}{{^if.text}} icon{{/if.text}}" {{#if.disabled}}disabled{{/if.disabled}}>
      {{#if.icon}}<span class="icon {{icon}}"></span>{{/if.icon}}
      {{#if.text}}<abbr>{{text}}aaaa</abbr>{{/if.text}}
    </button>"""

  event_form_va: (event, args...) =>
    console.log "callback :: event_form_va"
    @el.toggleClass "accept"
