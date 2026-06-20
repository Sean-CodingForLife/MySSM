package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DocumentController extends BaseController {

	private final static String documentPageUrl = "admin/document/document";
	
	@GetMapping("/admin/documents")
	public String toDocumentPage() {
		return DocumentController.documentPageUrl;
	}
	
}
