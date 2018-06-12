{* Paramètres > Types de contenants > *}
<h2>{t}Types de contenants{/t}</h2>
	<div class="row">
	<div class="col-md-6">
{if $droits.param == 1}
<a href="index.php?module=containerTypeChange&container_type_id=0">
{t}Nouveau...{/t}
</a>
{/if}
<table id="containerTypeList" class="table table-bordered table-hover datatable " >
<thead>
<tr>
<th>{t}Nom{/t}</th>
<th>{t}Id{/t}</th>
<th>{t}Famille{/t}</th>
<th>{t}Description{/t}</th>
<th>{t}Nombre
d'emplacements{/t}</th>
<th>{t}Condition de stockage{/t}</th>
<th>{t}Produit utilisé{/t}</th>
<th>{t}Code CLP (risque){/t}</th>
<th>{t}Modèle d'étiquette{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits.param == 1}
<a href="index.php?module=containerTypeChange&container_type_id={$data[lst].container_type_id}">
{$data[lst].container_type_name}
</a>
{else}
{$data[lst].container_type_name}
{/if}
</td>
<td class="center">{$data[lst].container_type_id}</td>
<td >
{$data[lst].container_family_name}
</td>
<td class="textareaDisplay">{$data[lst].container_type_description}</td>
<td>
{t 1=$data[lst].lines}L : %1{/t} {t 1=$data[lst].columns}C : %1{/t}
{if $data[lst].lines > 1}
<br>
{t}1ère ligne :{/t}
{if $data[lst].first_line == "T"}{t}haut{/t}
{else}{t}bas{/t}
{/if}
{/if}
</td>

<td>
{$data[lst].storage_condition_name}
</td>
<td>
{$data[lst].storage_product}
</td>
<td>
{$data[lst].clp_classification}
</td>
<td>
{$data[lst].label_name}
</td>
</tr>
{/section}
</tbody>
</table>
</div>
</div>