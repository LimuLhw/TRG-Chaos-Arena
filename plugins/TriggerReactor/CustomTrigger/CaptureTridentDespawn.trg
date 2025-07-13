//아아아아
IF event.getEntity().getType().toString() == "TRIDENT" && event.getEntity().getWorld().getName() == "CaptureGame"
	trident = event.getEntity()
	trident.remove()
ENDIF 