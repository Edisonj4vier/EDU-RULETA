import { ApiProperty } from '@nestjs/swagger';
import {
  IsString,
  MinLength,
  IsOptional,
  IsUrl,
  IsUUID,
} from 'class-validator';

export class CreateTopicDto {
  @ApiProperty({
    description: 'Nombre del tema',
    example: 'Álgebra Lineal',
    minLength: 3,
  })
  @IsString()
  @MinLength(3)
  nombre: string;

  @ApiProperty({
    description: 'Descripción del tema',
    example: 'Un tema sobre álgebra lineal básica y avanzada.',
    minLength: 10,
  })
  @IsString()
  @MinLength(10)
  descripcion: string;

  @ApiProperty({
    description: 'URL del video relacionado con el tema (opcional)',
    example: 'https://example.com/video.mp4',
    required: false,
  })
  @IsOptional()
  @IsUrl()
  url_video?: string;

  @ApiProperty({
    description: 'URL de la imagen relacionada con el tema (opcional)',
    example: 'https://example.com/image.png',
    required: false,
  })
  @IsOptional()
  @IsUrl()
  url_imagen?: string;

  @ApiProperty({
    description: 'ID del curso al que pertenece el tema',
    example: 'b4e2234f-9234-4d8c-b98d-9c55df12a92c',
  })
  @IsUUID()
  course_id: string;
}
