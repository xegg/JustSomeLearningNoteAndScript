package main

import (
	"encoding/xml"
	"fmt"
	"os"
	"strconv"
	"time"

	"github.com/bwmarrin/snowflake"
)

type UniBSS struct {
	OrigDomain     string
	HomeDomain     string
	BIPCode        string
	BIPVer         string
	ActivityCode   string
	ActionCode     string
	ActionRelation string
	Routing        routing
	ProcID         string
	TransIDO       string
	ProcessTime    string
	TestFlag       string
	MsgSender      string
	MsgReceiver    string
	SvcContVer     string
	SvcCont        CharData
}

type CharData struct {
	Text string `xml:",cdata"`
}

type routing struct {
	RouteType  string
	RouteValue string
}

type NumQeuryReq struct {
	AcceptType  string
	ServiceKind string
	ServiceID   string
	ExecCode    string
	ExecName    string
	InnetMethod string
	OperatorID  string
	Province    string
	City        string
	District    string
	ChannelID   string
	ChannelType string
	AccessType  string
	SerType     string
	BrandID     string
	ProductID   string
	QueryParas  queryParas
	Para        para
}

type queryParas struct {
	QueryType  string
	QueryPara1 string
	QueryPara2 string
}

type para struct {
	ParaID    string
	ParaValue string
}

func main() {
	v := &UniBSS{
		OrigDomain:     "ECIP",
		HomeDomain:     "USRM",
		BIPCode:        "AIPC001",
		BIPVer:         "0100",
		ActivityCode:   "T2000541",
		ActionCode:     "0",
		ActionRelation: "0",
		Routing:        routing{"0", "75"},
		MsgSender:      "1101",
		MsgReceiver:    "1100",
	}

	node, err := snowflake.NewNode(1)
	if err != nil {
		fmt.Println(err)
		return
	}
	v.ProcID = strconv.FormatInt(node.Generate().Int64(), 10)
	v.TransIDO = strconv.FormatInt(node.Generate().Int64(), 10)

	t := time.Now()
	v.ProcessTime = fmt.Sprintf("%d%02d%02d%02d%02d%02d", t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(), t.Second())

	v.TestFlag = "1"

	srv_content := &NumQeuryReq{}
	xml_content, err := xml.Marshal(srv_content)
	if err != nil {
		fmt.Printf("error: %v\n", err)
	}
	v.SvcCont = CharData{string(xml_content)}

	output, err := xml.MarshalIndent(v, "  ", "    ")
	if err != nil {
		fmt.Printf("error: %v\n", err)
	}

	os.Stdout.Write([]byte(xml.Header))
	os.Stdout.Write(output)
}
