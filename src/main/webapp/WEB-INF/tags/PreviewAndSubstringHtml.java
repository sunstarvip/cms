package com.xinfei.xyEdu.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class PreviewAndSubstringHtml extends TagSupport {
	
	private String content;
	private String tag;
	private int size = 0;
	private int subsize = 0;
	
	
	 public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public int getSize() {
		return size;
	}


	public void setSize(int size) {
		this.size = size;
	}


	public int getSubsize() {
		return subsize;
	}


	public void setSubsize(int subsize) {
		this.subsize = subsize;
	}

	@Override
    public int doAfterBody() throws JspException {
        return super.doAfterBody();
    }

	/**
     * 根据html标记截取html内容
     * @param content 目标html内容
     * @param tag 要截取的html标记
     * @param size 要截取的数量
     * @return 截取后的内容
     */
    @Override
    public int doEndTag() throws JspException {
    	if (StringUtils.isEmpty(this.content)) {
            return EVAL_PAGE;
        }
    	StringBuffer black = new StringBuffer();
        String blackString = "";
        String title = "";
        Document doc = Jsoup.parse(this.content);
        Elements con = doc.getElementsByTag(tag);
        if (this.size > con.size())
            this.size = con.size();
        for (int i = 0; i < this.size; i++){
            Element cp = con.get(i);
            blackString = blackString + cp.text();
        }
        title = blackString;
        if(this.subsize > 0){
        	if(this.subsize < blackString.length())
				blackString = blackString.substring(0, subsize);
        }
        try {
        	black.append("<label rel=\"tooltip\" title=\"");
        	black.append(title).append("\" class=\"tip-top\">");
            if(this.subsize < blackString.length())
                black.append(blackString+"...").append("</label>");
            else
                black.append(blackString).append("</label>");
			pageContext.getOut().write(black.toString());
		} catch (IOException e) {
			throw new JspException(e);
		}
        return EVAL_PAGE;
    }

    @Override
    public int doStartTag() throws JspException {
        return super.doStartTag();
    }
}
