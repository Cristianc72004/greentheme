{**
 * templates/frontend/pages/contact.tpl
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}

{* Para rutas de imágenes del tema (logos, etc.) *}
{assign var=pluginBaseUrl value=$baseUrl|cat:'/plugins/themes/greentheme'}

<div id="main-content" class="page page_contact">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.contact"}

	<div class="page-header">
		<h1>{translate key="about.contact"}</h1>
		{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}
	</div>

	{* ===== Mapa en tarjeta ===== *}
	<div class="gwj-map-card" aria-label="Mapa de ubicación">
		<div class="gwj-map-ratio">
			{* Satélite por defecto (t=k), zoom ajustable con z= *}
			<iframe
				title="Mapa de la oficina editorial"
				src="https://www.google.com/maps?q=0.0795609,-76.9015289&t=k&z=16&output=embed"
				loading="lazy"
				referrerpolicy="no-referrer-when-downgrade">
			</iframe>
		</div>

		<div class="gwj-map-actions">
			<a class="btn btn-default" target="_blank" rel="noopener"
			   href="https://www.google.com/maps/dir/-0.032768,-76.9458176/Chong%C3%B3n,+Nueva+Loja/@0.0071396,-76.995069,12z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x8e2823e432cba3f9:0x8a83551dd81637bb!2m2!1d-76.9015289!2d0.0795609?entry=ttu">
				Ver direcciones en Google Maps
			</a>
		</div>
	</div>

	{* ===== Datos debajo del mapa ===== *}
	<div class="gwj-contact-grid">

		{* Columna izquierda: dirección y contacto principal *}
		<div class="gwj-contact-box">
			<h3 class="gwj-contact-title">{translate key="about.contact.principalContact"}</h3>

			{if $contactName}<p class="mb-5"><strong>{$contactName|escape}</strong></p>{/if}
			{if $contactTitle}<p class="mb-5">{$contactTitle|escape}</p>{/if}
			{if $contactAffiliation}<p class="mb-5">{$contactAffiliation|strip_unsafe_html}</p>{/if}

			{if $mailingAddress}
				<p class="mb-5 gwj-address">{$mailingAddress|nl2br|strip_unsafe_html}</p>
			{/if}

			{if $contactEmail}
				<p class="mb-5"><strong>Email:</strong> {mailto address=$contactEmail encode='javascript'}</p>
			{/if}
			{if $contactPhone}
				<p class="mb-0"><strong>{translate key="about.contact.phone"}:</strong> {$contactPhone|escape}</p>
			{/if}
		</div>

		{* Columna derecha: logos + zona (texto libre) *}
		<div class="gwj-contact-box">
			<div class="gwj-logos-row">
				<img src="{$pluginBaseUrl}/images/logo-gwj.png" alt="Green World Journal" class="gwj-logo-small">
				<img src="{$pluginBaseUrl}/images/camera.png" alt="CaMeRa" class="gwj-logo-small">
			</div>

			<div class="gwj-zone">
				<h3 class="gwj-contact-title">Zona / Referencia</h3>
				<p class="mb-5">Lagune Julio Marín<br>Av. Jun Montufar R. &amp; Chongon</p>

				{if $supportName || $supportEmail || $supportPhone}
					<hr>
					<h4 class="mt-20">{translate key="about.contact.supportContact"}</h4>
					{if $supportName}<p class="mb-5"><strong>{$supportName|escape}</strong></p>{/if}
					{if $supportEmail}<p class="mb-5"><strong>Email:</strong> {mailto address=$supportEmail encode='javascript'}</p>{/if}
					{if $supportPhone}<p class="mb-0"><strong>{translate key="about.contact.phone"}:</strong> {$supportPhone|escape}</p>{/if}
				{/if}
			</div>
		</div>

	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
