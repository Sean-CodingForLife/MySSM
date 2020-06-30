package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/document")
public class DocumentController extends BaseController {

	private final static String documentPageUrl = "admin/document/document";
	
	@GetMapping
	public String toDocumentPage() {
		return DocumentController.documentPageUrl;
	}
	
}
