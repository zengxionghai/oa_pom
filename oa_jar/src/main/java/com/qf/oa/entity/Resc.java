package com.qf.oa.entity;

import java.io.Serializable;

public class Resc implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.pid
     *
     * @mbggenerated
     */
    private Integer pid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.resname
     *
     * @mbggenerated
     */
    private String resname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.respath
     *
     * @mbggenerated
     */
    private String respath;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.resdesc
     *
     * @mbggenerated
     */
    private String resdesc;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column resc.resstate
     *
     * @mbggenerated
     */
    private Integer resstate;

    private boolean checked;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table resc
     *
     * @mbggenerated
     */
    private static final long serialVersionUID = 1L;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.id
     *
     * @return the value of resc.id
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.id
     *
     * @param id the value for resc.id
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.pid
     *
     * @return the value of resc.pid
     * @mbggenerated
     */
    public Integer getPid() {
        return pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.pid
     *
     * @param pid the value for resc.pid
     * @mbggenerated
     */
    public void setPid(Integer pid) {
        this.pid = pid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.resname
     *
     * @return the value of resc.resname
     * @mbggenerated
     */
    public String getResname() {
        return resname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.resname
     *
     * @param resname the value for resc.resname
     * @mbggenerated
     */
    public void setResname(String resname) {
        this.resname = resname == null ? null : resname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.respath
     *
     * @return the value of resc.respath
     * @mbggenerated
     */
    public String getRespath() {
        return respath;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.respath
     *
     * @param respath the value for resc.respath
     * @mbggenerated
     */
    public void setRespath(String respath) {
        this.respath = respath == null ? null : respath.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.resdesc
     *
     * @return the value of resc.resdesc
     * @mbggenerated
     */
    public String getResdesc() {
        return resdesc;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.resdesc
     *
     * @param resdesc the value for resc.resdesc
     * @mbggenerated
     */
    public void setResdesc(String resdesc) {
        this.resdesc = resdesc == null ? null : resdesc.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column resc.resstate
     *
     * @return the value of resc.resstate
     * @mbggenerated
     */
    public Integer getResstate() {
        return resstate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column resc.resstate
     *
     * @param resstate the value for resc.resstate
     * @mbggenerated
     */
    public void setResstate(Integer resstate) {
        this.resstate = resstate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table resc
     *
     * @mbggenerated
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Resc other = (Resc) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
                && (this.getPid() == null ? other.getPid() == null : this.getPid().equals(other.getPid()))
                && (this.getResname() == null ? other.getResname() == null : this.getResname().equals(other.getResname()))
                && (this.getRespath() == null ? other.getRespath() == null : this.getRespath().equals(other.getRespath()))
                && (this.getResdesc() == null ? other.getResdesc() == null : this.getResdesc().equals(other.getResdesc()))
                && (this.getResstate() == null ? other.getResstate() == null : this.getResstate().equals(other.getResstate()));
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table resc
     *
     * @mbggenerated
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getPid() == null) ? 0 : getPid().hashCode());
        result = prime * result + ((getResname() == null) ? 0 : getResname().hashCode());
        result = prime * result + ((getRespath() == null) ? 0 : getRespath().hashCode());
        result = prime * result + ((getResdesc() == null) ? 0 : getResdesc().hashCode());
        result = prime * result + ((getResstate() == null) ? 0 : getResstate().hashCode());
        return result;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table resc
     *
     * @mbggenerated
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", pid=").append(pid);
        sb.append(", resname=").append(resname);
        sb.append(", respath=").append(respath);
        sb.append(", resdesc=").append(resdesc);
        sb.append(", resstate=").append(resstate);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
}