import dragula from 'dragula';
import _ from 'lodash';
import '../utilities/lodashmixins';
import { updateSortOrder } from '../models/section';
import { getElementIndex } from '../utilities/htmlhelpers';
import { PreferencesService } from '../services';

<preferences>
  <h2>
    <button class="btn btn-primary pull-right" type="button" name="button" onclick={ save }>Save</button>
    Which sections would you like to see?
    <small>
      <a href="#" onclick={ enableAll }>all</a> | <a href="#" onclick={ disableAll }>none</a>
      (drag to sort)</small>
  </h2>
  <ul class="list-group" id="preferences">
    <preference-section each={ opts.sections }/>
  </div>

  <script>
    var self = this;
    this.preferenceService = new PreferencesService();

    this.on('mount', function () {
      updateSortOrder();
      var container = document.getElementById('preferences');
      dragula([container], {direction: 'vertical'}).on('drop', drop);
    });

    function drop(el) {
      var from = _.findIndex(opts.sections, { key: el.key });
      var to = getElementIndex(el);
      _.move(opts.sections, from, to);
      updateSortOrder();
      self.update();
    }

    enableAll() {
      _.each(opts.sections, function(s) {
        s.enabled = true;
      });
    }

    disableAll() {
      _.each(opts.sections, function(s) {
        s.enabled = false;
      });
    }

    save() {
      this.parent.showPreferences = false;
      riot.update();
    }

  </script>
</preferences>

<preference-section>
  <li class="list-group-item preferences-section text-right">
    <label class="checkbox-inline pull-left">
      <input type="checkbox" checked={ enabled } onchange={ change }>
      { display }
    </label>
    <i class="fa fa-bars" title="Drag to sort"></i>
  </div>

  <script>
    this.root.key = this.key;

    change(e) {
      e.item.enabled = e.target.checked;
      this.update();
    }
  </script>
</preference-section>
