{* Objets > échantillons > Rechercher > UID d'un échantillon > section Evénements > Nouveau... > *}
<h2>{t}Création - modification d'un événement{/t}</h2>

<div class="row">
<div class="col-md-6">
<a href="index.php?module={$moduleListe}">
<img src="{$display}/images/list.png" height="25">
{t}Retour à la liste{/t}
</a>
<a href="index.php?module={$moduleParent}Display&uid={$object.uid}">
<img src="{$display}/images/edit.gif" height="25">
{t}Retour au détail{/t} ({$object.uid} {$object.identifier})
</a>
<form class="form-horizontal protoform" id="{$moduleParent}Form" method="post" action="index.php">
<input type="hidden" name="event_id" value="{$data.event_id}">
<input type="hidden" name="moduleBase" value="{$moduleParent}event">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="uid" value="{$object.uid}">

<div class="form-group">
<label for="event_date" class="control-label col-md-4">{t}Date :{/t}</label>
<div class="col-md-8">
<input id="event_date" name="event_date" required value="{$data.event_date}" class="form-control datepicker" >
</div>
</div>


<div class="form-group">
<label for="container_status_id" class="control-label col-md-4"><span class="red">*</span> {t}Type d'évenement :{/t}</label>
<div class="col-md-8">
<select id="event_type_id" name="event_type_id" class="form-control">
{section name=lst loop=$eventType}
<option value="{$eventType[lst].event_type_id}" {if $eventType[lst].event_type_id == $data.event_type_id}selected{/if}>
{$eventType[lst].event_type_name}
</option>
{/section}
</select>
</div>
</div>
{if $moduleParent == "sample"}
<div class="form-group">
<label for="still_available" class="control-label col-md-4">{t}Reste disponible :{/t}</label>
<div class="col-md-8">
<input id="still_available" type="text" name="still_available"  value="{$data.still_available}" class="form-control" >
</div>
</div>
{/if}
<div class="form-group">
<label for="event_comment" class="control-label col-md-4">{t}Commentaire :{/t}</label>
<div class="col-md-8">
<textarea id="event_comment" name="event_comment"  class="form-control" rows="3">{$data.event_comment}</textarea>
</div>
</div>

<div class="form-group center">
      <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
      {if $data.event_id > 0 }
      <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
      {/if}
 </div>
</form>
</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Donnée obligatoire{/t}</span>