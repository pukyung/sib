package pj;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class SpringVO {

	//관리자 추가 2022-02-04
	private String aid = null;
	private String apw = null;
	public String getAid() {return this.aid;}
	public String getApw() {return this.apw;}
	
	public void setAid(String aid) {this.aid = aid;}
	public void setApw(String apw) {this.apw = apw;}
	
	// 소비자
	private String cusid = null;
	private String cuspw = null;
	private String cusname = null;
	private String cusaddr = null;
	private Integer cusphone = null;
	private String cusmail = null;
	private Integer cusresid = null;
	
	public String getCusid() { return cusid; }
	public String getCuspw() { return cuspw; }
	public String getCusname() { return cusname; }
	public String getCusaddr() { return cusaddr; }
	public Integer getCusphone() { return cusphone; }
	public String getCusmail() { return cusmail; }
	public Integer getCusresid() {return cusresid;}
	
	public void setCusid(String cusid) { this.cusid = cusid; }
	public void setCuspw(String cuspw) { this.cuspw = cuspw; }
	public void setCusname(String cusname) { this.cusname = cusname; }
	public void setCusaddr(String cusaddr) { this.cusaddr = cusaddr; }
	public void setCusphone(Integer cusphone) { this.cusphone = cusphone; }
	public void setCusmail(String cusmail) { this.cusmail = cusmail; }
	public void setCusresid(Integer cusresid) {this.cusresid = cusresid;}
	
	// 판매자
	private String selid = null;
	private String selpw = null;
	private String selname = null;
	private Integer selnum = null;
	private Integer selphone = null;
	private String seladdr = null;
	private String repname = null;

	public String getSelid() { return selid; }
	public String getSelpw() { return selpw; }
	public String getSelname() { return selname; }
	public Integer getSelnum() { return selnum; }
	public Integer getSelphone() { return selphone; }
	public String getSeladdr() { return seladdr; }
	public String getRepname() { return repname; }
	
	public void setSelid(String selid) { this.selid = selid; }
	public void setSelpw(String selpw) { this.selpw = selpw; }
	public void setSelname(String selname) { this.selname = selname; }
	public void setSelnum(Integer selnum) { this.selnum = selnum; }
	public void setSelphone(Integer selphone) { this.selphone = selphone; }
	public void setSeladdr(String seladdr) { this.seladdr = seladdr; }
	public void setRepname(String repname) { this.repname = repname; }
	
	// 판매자 검사
	private Integer valid = null;

	public Integer getValid() { return valid; }
	
	public void setValid(Integer valid) { this.valid = valid; }
	
	// 상품
	private Integer pid = null;
	private String ppid = null;
	private String pname = null;
	private String porigin = null;
	private Integer price = null;
	private Integer organic = null;
	private String shipment = null;
	private Integer type = null;
	private String unit = null;
	private Integer pcount = null;
	private String search = null;

	public Integer getPid() { return pid; }
	public String getPpid() { return ppid; }
	public String getPname() { return pname; }
	public String getPorigin() { return porigin; }
	public Integer getPrice() { return price; }
	public Integer getOrganic() { return organic; }
	public String getShipment() { return shipment; }
	public Integer getType() { return type; }
	public String getUnit() { return unit; }
	public Integer getPcount() { return pcount; }
	public String getSearch() { return search; }
	
	public void setPid(Integer pid) { this.pid = pid; }
	public void setPpid(String ppid) { this.ppid = ppid; }
	public void setPname(String pname) { this.pname = pname; }
	public void setPorigin(String porigin) { this.porigin = porigin; }
	public void setPrice(Integer price) { this.price = price; }
	public void setOrganic(Integer organic) { this.organic = organic; }
	public void setShipment(String shipment) { this.shipment = shipment; }
	public void setType(Integer type) { this.type = type; }
	public void setUnit(String unit) { this.unit = unit; }
	public void setPcount(Integer count) { this.pcount = count; }
	public void setSearch(String search) { this.search = search; }
	
	// 공지사항
	private Integer pnum = null;
	private String title = null;
	private String content = null;
	private String date = null;
	private Integer important = null;

	public Integer getPnum() { return pnum; }
	public String getTitle() { return title; }
	public String getContent() { return content; }
	public String getDate() { return date; }
	public Integer getImportant() { return important; }
	
	public void setPnum(Integer pnum) { this.pnum = pnum; }
	public void setTitle(String title) { this.title = title; }
	public void setContent(String content) { this.content = content; }
	public void setDate(String string) { this.date = string; }
	public void setImportant(Integer important) { this.important = important; }
	
	// 장바구니
	private Integer cnum = null;
	private Integer count  = null;
	private Integer total = null;

	public Integer getCnum() { return cnum; }
	public Integer getCount() { return count; }
	public Integer getTotal() { return total; }
	
	public void setCnum(Integer cnum) { this.cnum = cnum; }	
	public void setCount(Integer count) { this.count = count; }
	public void setTotal(Integer total) { this.total = total; }
	
	// 주문
	private Integer odnum = null;
	private String addr = null;
	private Integer phone = null;
	private Date odate = null;

	public Integer getOdnum() { return odnum; }
	public String getAddr() { return addr; }
	public Integer getPhone() { return phone; }
	public Date getOdate() {return odate;}

	public void setOdnum(Integer odnum) { this.odnum = odnum; }
	public void setAddr(String addr) { this.addr = addr; }
	public void setPhone(Integer phone) { this.phone = phone; }
	public void setOdate(Date odate) {this.odate = odate;}
	
	// 주문내역
	private Integer odanum = null;

	public Integer getOdanum() { return odanum; }
	
	public void setOdanum(Integer odanum) { this.odanum = odanum; }
	
	// 리뷰
	private Integer rnum = null;
	private String answer = null;
	private Double score = null;
	private String image = null;

	public Integer getRnum() { return rnum; }
	public String getAnswer() { return answer; }
	public Double getScore() { return score; }
	public String getImage() { return image; }
	
	public void setRnum(Integer rnum) { this.rnum = rnum; }
	public void setAnswer(String answer) { this.answer = answer; }
	public void setScore(Double score) { this.score = score; }
	public void setImage(String image) { this.image = image; }
	
	// 사진
	private Integer inum = null;

	public Integer getInum() { return inum; }
	
	public void setInum(Integer inum) { this.inum = inum; }

	// QnA
	
	private Integer qno = null;

	public Integer getQno() { return qno; }
	
	public void setQno(Integer qno) { this.qno = qno; }
	
	// 기타
	
	private String option = null;
	private String option2 = null;
	private Integer forcount = null;
	private Date ddate = null;
	//private MultipartFile iimage = null;

	public String getOption() { return option; }
	public String getOption2() { return option2; }
	public Integer getForcount() { return forcount; }
	public Date getDdate() { return ddate; }
	//public MultipartFile getIfile() { return iimage; }
	
	public void setOption(String option) { this.option = option; }
	public void setOption2(String option2) { this.option2 = option2; }
	public void setForcount(Integer forcount) { this.forcount = forcount; }
	public void setDdate(Date ddate) { this.ddate = ddate; }
	//public void setIfile(MultipartFile iimage) { this.iimage = iimage; }
	
	
	private Date sqldate = null;
	
	public Date getSqldate() { return sqldate; }
	
	public void setSqldate(Date sqldate) { this.sqldate = sqldate; }
	
	
}
