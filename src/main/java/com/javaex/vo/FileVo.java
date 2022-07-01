package com.javaex.vo;

public class FileVo {
	
	private String orgName;
	private String saveName;
	private String filePath;
	private long fileSize;

	public FileVo() {}
	
	public FileVo(String orgName, String saveName, String filePath, long fileSize) {
		this.orgName = orgName;
		this.saveName = saveName;
		this.filePath = filePath;
		this.fileSize = fileSize;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getSaveName() {
		return saveName;
	}

	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	@Override
	public String toString() {
		return "FileVo [orgName=" + orgName + ", saveName=" + saveName + ", filePath=" + filePath + ", fileSize="
				+ fileSize + "]";
	}
	

}
