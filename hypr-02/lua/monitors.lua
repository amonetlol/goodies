-- Monitors for this host (VMware Virtual-1).

hl.monitor({
	output = "Virtual-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

-- Fallback for any extra display.
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.workspace_rule({ workspace = "1", monitor = "Virtual-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "3", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "4", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "5", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "6", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "7", monitor = "Virtual-1" })
hl.workspace_rule({ workspace = "8", monitor = "Virtual-1" })
