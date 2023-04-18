import RpFormatter from "rupiah-format";

const convertRp = (nominal) => {
  return RpFormatter.convert(nominal);
};

export default convertRp;
